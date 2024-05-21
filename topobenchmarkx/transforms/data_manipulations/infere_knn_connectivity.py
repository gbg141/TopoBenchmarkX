import torch_geometric
from torch_geometric.nn import knn_graph

class InfereKNNConnectivity(torch_geometric.transforms.BaseTransform):
    r"""A transform that generates the k-nearest neighbor connectivity of the
    input point cloud.

    Args:
        kwargs (optional): Parameters for the base transform."""

    def __init__(self, **kwargs):
        super().__init__()
        self.type = "infere_knn_connectivity"
        self.parameters = kwargs
        
    def __repr__(self) -> str:
        return f"{self.__class__.__name__}(type={self.type!r}, parameters={self.parameters!r})"

    def forward(self, data: torch_geometric.data.Data):
        r"""Apply the transform to the input data.

        Args:
            data (torch_geometric.data.Data): The input data.
        Returns:
            torch_geometric.data.Data: The transformed data.
        """

        edge_index = knn_graph(data.x, **self.parameters["args"])

        # Remove duplicates
        data.edge_index = edge_index
        return data