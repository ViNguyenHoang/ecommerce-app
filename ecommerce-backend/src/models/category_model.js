const { Schema, model } = require("mongoose");

const categorySchema = new Schema({
	title: { type: String, required: [true, "title is required"] },
	description: { type: String, default: "" },
	updatedAt: { type: Date },
	createdAt: { type: Date },
});

categorySchema.pre("save", function (next) {
	this.updatedAt = new Date();
	this.createdAt = new Date();

	next();
});

categorySchema.pre(
	["update", "findOneAndUpdate", "updateOne"],
	function (next) {
		const update = this.getUpdate();
		delete update._id;

		this.updatedAt = new Date();

		next();
	},
);

const CategoryModel = model("Category", categorySchema);

module.exports = CategoryModel;
