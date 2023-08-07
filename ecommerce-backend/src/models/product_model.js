const { Schema, model } = require("mongoose");

const productSchema = new Schema({
	category: { type: Schema.Types.ObjectId, ref: "Category", required: true },
	title: { type: String, required: [true, "title is required"] },
	description: { type: String, default: "" },
	price: { type: Number, required: true },
	images: { type: Array, default: [] },
	updatedAt: { type: Date },
	createdAt: { type: Date },
});

productSchema.pre("save", function (next) {
	this.updatedAt = new Date();
	this.createdAt = new Date();

	next();
});

productSchema.pre(["update", "findOneAndUpdate", "updateOne"], function (next) {
	const update = this.getUpdate();
	delete update._id;

	this.updatedAt = new Date();

	next();
});

const ProductModel = model("Product", productSchema);

module.exports = ProductModel;
