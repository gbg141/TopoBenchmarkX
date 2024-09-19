"""Feature lifting transforms."""

from .concatenation import Concatenation
from .duplicate import Duplicate
from .identity import Identity
from .projection_sum import ProjectionSum
from .set import Set

FEATURE_LIFTINGS = {
    "Concatenation": Concatenation,
    "ProjectionSum": ProjectionSum,
    "Set": Set,
    "Duplicate": Duplicate,
    None: Identity,
}

__all__ = [
    "Concatenation",
    "ProjectionSum",
    "Set",
    "Duplicate",
    "FEATURE_LIFTINGS",
]
