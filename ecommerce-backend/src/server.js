const express = require("express");
const bodyParser = require("body-parser");
const helmet = require("helmet");
const morgan = require("morgan");
const cors = require("cors");
const mongoose = require("mongoose");

const app = express();
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(helmet());
app.use(morgan("dev"));
app.use(cors());

mongoose.connect(
	"mongodb+srv://dbdbd9:dbdbd9@cluster0.uivbsip.mongodb.net/ecommerce?retryWrites=true&w=majority",
);

const UserRoutes = require("./routes/user_routes");
app.use("/api/user", UserRoutes);

const CategoryRoutes = require("./routes/category_routes");
app.use("/api/category", CategoryRoutes);

const ProductRoutes = require("./routes/product_routes");
app.use("/api/product", ProductRoutes);

const CartRoutes = require("./routes/cart_routes");
app.use("/api/cart", CartRoutes);

const OrderRoutes = require("./routes/order_routes");
app.use("/api/order", OrderRoutes);

app.get("/", function (req, res) {
	res.send("Hello world");
});

const PORT = 5000;
const server = app.listen(PORT, () =>
	console.log(`Server started ar PORT: ${PORT}`),
);

const io = require("socket.io")(server);

io.on("connection", (socket) => {
	console.log("Connected Successfully", socket.id);

	socket.on("disconnect", () => {
		console.log("Disconnected", socket.id);
	});

	socket.on("message", (data) => {
		console.log(data);

		socket.broadcast.emit("message-receive", data);
	});
});
