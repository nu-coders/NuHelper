const express = require("express");

const backend = require("./backend.js");
const cors = require("cors")
const app = express();
app.use(express.json());
app.use(cors());
const router = express.Router();
const port = 8081;

function api() {
  router.get("/api", (req, res) => {
    res.send({ NuCoders: "Hello World" });
  });

  // ok
  router.get("/api/getroom/", async (req, res) => {
    // 127.0.0.1:8080/api/getroom/
    let id = req.query.id;
    if (id == null || id == "") {
      res.status(404).json({ error: "Not a room" });
    } else {
      let response = await backend.getRoom(id);
      if (response == -1) {
        res.status(404).json({ error: "Not a room" });
      } else if (response == 0) {
        res.status(405).json({ error: "Outsite Working Hours" });
      } else {
        res.send(response);
      }
    }
  });

  //ok
  router.get("/api/getrooms/", async (req, res) => {
    // http://127.0.0.1:8080/api/getrooms/
    let building = req.query.building;
    if (building == null || building == "") {
      res.status(404).json({ error: "Not a building" });
    } else {
      let response = await backend.getRooms(building);
      if (response === -1) {
        res.status(404).json({ error: "Not a building" });
      } else if (response == 0) {
        res.status(405).json({ error: "Outsite Working Hours" });
      } else {
        res.send(response);
      }
    }
  });

  // ok
  router.get("/api/roomtable", async (req, res) => {
    // http://127.0.0.1:8080/api/roomtable/
    let id = req.query.id;
    if (id == null || id == "") {
      res.status(404).json({ error: "Not a room" });
    } else {
      let response = await backend.roomTable(id);
      if (response == -1) {
        res.status(404).json({ error: "Not a room" });
      } else if (response == 0) {
        res.status(405).json({ error: "Outsite Working Hours" });
      } else {
        res.send(response);
      }
    }
  });

  // ok
  router.get("/api/suglist", async (req, res) => {
    // http://127.0.0.1:8080/api/suglist/
    res.send(await backend.roomsSuggestion());
  });

  app.use("/", router);

  app.use((req, res) => {
    res.sendStatus(404);
  });

  app.listen(port, () => {
    console.log("runing server on " +port);
  });
}

async function main() {
  await backend.cachingData();
  api();
  await backend.updateData();
}
main();
