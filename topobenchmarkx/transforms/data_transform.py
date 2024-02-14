# from abc import ABC, abstractmethod

import torch_geometric

from topobenchmarkx.transforms.liftings.graph2cell import CellCyclesLifting
from topobenchmarkx.transforms.liftings.graph2hypergraph import (
    HypergraphKHopLifting,
    HypergraphKNearestNeighborsLifting,
)
from topobenchmarkx.transforms.liftings.graph2simplicial import (
    SimplicialCliqueLifting,
    SimplicialNeighborhoodLifting,
)


class IdentityTransform:
    def __init__(self, **kwargs):
        super().__init__()
        self.type = "domain2domain"
        self.parameters = kwargs

    def forward(self, data: torch_geometric.data.Data) -> dict:
        return data

    def __call__(self, data):
        return self.forward(data)


TRANSFORMS = {
    ###
    # Graph -> Hypergraph
    "HypergraphKHopLifting": HypergraphKHopLifting,
    "HypergraphKNearestNeighborsLifting": HypergraphKNearestNeighborsLifting,
    # Graph -> Simplicial Complex
    "SimplicialNeighborhoodLifting": SimplicialNeighborhoodLifting,
    "SimplicialCliqueLifting": SimplicialCliqueLifting,
    # Graph -> Cell Complex
    "CellCyclesLifting": CellCyclesLifting,
    # Identity
    "Identity": IdentityTransform,
}


class DataTransform(torch_geometric.transforms.BaseTransform):
    """Abstract class that provides an interface to define a custom data lifting"""

    def __init__(self, transform_name, **kwargs):
        super().__init__()

        self.preserve_parameters(transform_name, **kwargs)

        self.transform = (
            TRANSFORMS[transform_name](**kwargs) if transform_name is not None else None
        )

    def forward(self, data: torch_geometric.data.Data) -> torch_geometric.data.Data:
        """Forward pass of the lifting"""
        transformed_data = self.transform(data)  # if self.lifting is not None else data
        return transformed_data

    def __call__(self, data):
        return self.forward(data)

    def preserve_parameters(self, transform_name, **kwargs):
        kwargs["transform_name"] = transform_name
        self.parameters = kwargs


if __name__ == "__main__":
    _ = DataTransform()
