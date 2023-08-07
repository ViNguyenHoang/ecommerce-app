const CartModel = require("./../models/cart_model");

const CartController = {
	getCartForUser: async function (req, res) {
		try {
			const user = req.params.user;

			const foundCart = await CartModel.findOne({ user: user }).populate("items.product");

			if (!foundCart) {
				return res.json({
					success: true,
					data: [],
				});
			}

			return res.json({
				success: true,
				data: foundCart.items,
			});
		} catch (ex) {
			return res.json({ success: false, message: ex });
		}
	},

	addToCart: async function (req, res) {
		try {
			const { product, user, quantity } = req.body;

			const foundCart = await CartModel.findOne({ user: user });

			// Cart is not existed
			if (!foundCart) {
				const newCart = new CartModel({ user: user });
				newCart.items.push({
					product: product,
					quantity: quantity,
				});

				await newCart.save();

				return res.json({
					success: true,
					data: newCart,
					message: "Product added to cart!",
				});
			}

			const deletedItem =  await CartModel.findOneAndUpdate(
				{ user: user, "items.product": product },
				{ $pull: { items: { product: product } } },
				{ new: true },
			);

			// Cart is existed
			const updatedCart = await CartModel.findOneAndUpdate(
				{ user: user },
				{ $push: { items: { product: product, quantity: quantity } } },
				{ new: true },
			).populate("items.product");

			return res.json({
				success: true,
				data: updatedCart.items,
				message: "Product added to cart!",
			});
		} catch (ex) {
			return res.json({ success: false, message: ex });
		}
	},

	removeFromCart: async function (req, res) {
		try {
			const { product, user } = req.body;

			const updatedCart = await CartModel.findOneAndUpdate(
				{ user: user },
				{ $pull: { items: { product: product } } },
                { new: true }
			).populate("items.product");;

			return res.json({
				success: true,
				data: updatedCart,
				message: "Product removed from cart!",
			});
		} catch (ex) {
			return res.json({ success: false, message: ex });
		}
	},
};

module.exports = CartController;
