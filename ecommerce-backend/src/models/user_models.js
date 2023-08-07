const { Schema, model } = require("mongoose");
const uuid = require("uuid");
const bcrypt = require("bcrypt");

const userSchema = new Schema({
	id: { type: String, unique: true },
	fullName: { type: String, default: "" },
	email: { type: String, unique: true, required: true },
	password: { type: String, required: true },
	phoneNumber: { type: String, unique: true, default: "" },
	address: { type: String, default: "" },
	city: { type: String, default: "" },
	state: { type: String, default: "" },
	profileProgress: { type: Number, default: 0 },
	updatedAt: { type: Date },
	createdAt: { type: Date },
});

userSchema.pre("save", function (next) {
	this.id = uuid.v1();
	this.updatedAt = new Date();
	this.createdAt = new Date();

	//Hash password
	const salt = bcrypt.genSaltSync(10);
	const hash = bcrypt.hashSync(this.password, salt);
	this.password = hash;

	next();
});

userSchema.pre(["update", "findOneAndUpdate", "updateOne"], function (next) {
	const update = this.getUpdate();
	delete update._id;
	delete update.id;

	this.updatedAt = new Date();

	next();
});

const UserModel = model("User", userSchema);

module.exports = UserModel;
