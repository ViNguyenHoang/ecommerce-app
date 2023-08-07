const ProductModel = require("./../models/product_model");

const ProductController = {
	createProduct: async function (req, res) {
		try {
			const productData = req.body;
			const newProduct = new ProductModel(productData);
			await newProduct.save();

			return res.json({
				success: true,
				data: newProduct,
				message: "Product created!",
			});
		} catch (ex) {
			return res.json({ success: false, message: ex });
		}
	},

	getAllProducts: async function (req, res) {
		try {
			const products = await ProductModel.find();

			return res.json({
				success: true,
				data: products,
			});
		} catch (ex) {
			return res.json({ success: false, message: ex });
		}
	},

	getProductById: async function (req, res) {
		try {
			const id = req.params.id;
			const foundProduct = await ProductModel.findById(id);

			if (!foundProduct) {
				return res.json({
					success: false,
					message: "Product not found",
				});
			}

			return res.json({
				success: true,
				data: foundProduct,
			});
		} catch (ex) {
			return res.json({ success: false, message: ex });
		}
	},

	getProductByCategoryId: async function (req, res) {
		try {
			const categoryId = req.params.id;
			const products = await ProductModel.find({ category: categoryId });

			return res.json({
				success: true,
				data: products,
			});
		} catch (ex) {
			return res.json({ success: false, message: ex });
		}
	},
};

module.exports = ProductController;
