import { PrismaClient } from "@prisma/client";
import Cors from "cors";
const prisma = new PrismaClient();

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
  res.json(
    await prisma.objects.findMany({
      select: {
        id: true,
        tag: true,
        name: true,
        frequency: true,
      },
    })
  );
};
