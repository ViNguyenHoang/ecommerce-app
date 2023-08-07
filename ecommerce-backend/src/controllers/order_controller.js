const CartModel = require("../models/cart_model");
const OrderModel = require("./../models/order_model");

const OrderController = {
	createOrder: async function (req, res) {
		try {
			const { user, items, status } = req.body;
			const newOrder = new OrderModel({
				user: user,
				items: items,
				status: status
			});

			await newOrder.save();

			await CartModel.findOneAndUpdate(
				{user: user},
				{items: []}
			);

			return res.json({
				success: true,
				data: newOrder,
				message: "Order created!",
			});
		} catch (ex) {
			return res.json({ success: false, message: ex });
		}
	},

	getOrdersFroUser: async function (req, res) {
		try {
			const userId = req.params.id;

			const foundOrders = await OrderModel.find({
				"user._id": userId,
			}).sort({createdAt: -1});

			return res.json({ success: true, data: foundOrders });
		} catch (ex) {
			return res.json({ success: false, message: ex });
		}
	},

	updateOrderStatus: async function (req, res) {
		try {
			const { orderId, status } = req.body;

			const updatedOrder = await OrderModel.findOneAndUpdate(
				{ _id: orderId },
				{ status: status },
				{ new: true },
			);

			return res.json({ success: true, data: updatedOrder });
		} catch (ex) {
			return res.json({ success: false, message: ex });
		}
	},
};

module.exports = OrderController;
