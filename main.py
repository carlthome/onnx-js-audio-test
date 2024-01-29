import torch
import torch.nn as nn


class Model(nn.Module):
    def __init__(self):
        super().__init__()

    def forward(self, x):
        return x


def main():
    model = Model()
    input_names = ["input"]
    output_names = ["output"]

    input_data = torch.tensor([[1.0], [2.0], [3.0]])
    output_data = model(input_data)
    print(f"Input data: {input_data}\nOutput data: {output_data}")

    onnx_path = "model.onnx"
    torch.onnx.export(
        model,
        input_data,
        onnx_path,
        input_names=input_names,
        output_names=output_names,
    )
    print("Model exported to:", onnx_path)


if __name__ == "__main__":
    main()
