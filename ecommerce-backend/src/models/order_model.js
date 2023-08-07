const { Schema, model } = require("mongoose");

const orderItemSchema = new Schema({
	product: { type: Map, required: true },
	quantity: { type: Number, default: 1 },
});

const orderSchema = new Schema({
	user: { type: Map, ref: "User", required: true },
	items: { type: [orderItemSchema], default: [] },
	status: { type: String, default: "order-placed" },
	updatedAt: { type: Date },
	createdAt: { type: Date },
});

orderSchema.pre("save", function (next) {
	this.updatedAt = new Date();
	this.createdAt = new Date();

	next();
});

orderSchema.pre(["update", "findOneAndUpdate", "updateOne"], function (next) {
	const update = this.getUpdate();
	delete update._id;

	this.updatedAt = new Date();

	next();
});

const Order = model("order", orderSchema);

module.exports = Order;
