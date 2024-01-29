import * as ort from "onnxruntime-web";

async function main() {
  try {
    const session = await ort.InferenceSession.create("./model.onnx");

    const data = Float32Array.from([1.0, 2.0, 3.0]);
    const dims = [3, 1];
    const feeds = {
      input: new ort.Tensor("float32", data, dims),
    };
    const fetches = await session.run(feeds);
    const output = fetches.output.data;
    console.log(output);
  } catch (e) {
    console.error(e);
  }
}

main();
