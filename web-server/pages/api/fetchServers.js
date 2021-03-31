import prisma from "../../lib/server/prisma";
import Cors from "cors";

const cors = Cors({
  methods: ["GET", "HEAD"],
});

function runMiddleware(req, res, fn) {
  return new Promise((resolve, reject) => {
    fn(req, res, (result) => {
      if (result instanceof Error) {
        return reject(result);
      }

      return resolve(result);
    });
  });
}

export default async (req, res) => {
  await runMiddleware(req, res, cors);
  const servers = await prisma.servers.findMany({
    select: {
      tag: true,
      name: true,
    },
  });
  res.status(200).json(servers);
};
