const { Schema, model } = require("mongoose");

const cartItemSchema = new Schema({
	product: { type: Schema.Types.ObjectId, ref: "Product" },
	quantity: { type: Number, default: 1 },
});

const cartSchema = new Schema({
	user: { type: Schema.Types.ObjectId, ref: "User", required: true },
	items: { type: [cartItemSchema], default: [] },
	updatedAt: { type: Date },
	createdAt: { type: Date },
});

cartSchema.pre("save", function (next) {
	this.updatedAt = new Date();
	this.createdAt = new Date();

	next();
});

cartSchema.pre(["update", "findOneAndUpdate", "updateOne"], function (next) {
	const update = this.getUpdate();
	delete update._id;

	this.updatedAt = new Date();

	next();
});

const CartModel = model("cart", cartSchema);

module.exports = CartModel;
