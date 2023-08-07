const UserModel = require("./../models/user_models");
const bcrypt = require("bcrypt");

const UserController = {
	signUp: async function (req, res) {
		try {
			const userData = req.body;
			const newUser = new UserModel(userData);
			await newUser.save();

			return res.json({
				success: true,
				data: newUser,
				message: "User created!",
			});
		} catch (ex) {
			return res.json({ success: false, message: ex });
		}
	},

	signIn: async function (req, res) {
		try {
			const { email, password } = req.body;
			const foundUser = await UserModel.findOne({ email: email });
			if (!foundUser) {
				return res.json({ success: false, message: "User not found!" });
			}

			const passwordMatch = bcrypt.compareSync(
				password,
				foundUser.password,
			);

			if (!passwordMatch) {
				return res.json({
					success: false,
					message: "Email or password incorrect",
				});
			}

			return res.json({
				success: true,
				data: foundUser,
				message: "Sign in success",
			});
		} catch (ex) {
			return res.json({ success: false, message: ex });
		}
	},
};

module.exports = UserController;
