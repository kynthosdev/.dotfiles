from attr import define, field
from uuid import uuid4

# from chrmndr.events import card_events


@define
class Card:
    owner: str
    name: str
    type_line: str

    game_id: str = field(default=str(uuid4()))
    # card_faces: List[CardFace] = field(factory=list)

    # mtgo_id: int = field(converter=int)
    # id: int = field(converter=int)
    # uri: str

    # cmc: int = field(converter=int)
    # color_identity: str
    # color_indicator: str
    # colors: str
    # loyalty: str
    # mana_cost: str
    # oracle_text: str
    # power: str
    # toughness: str

    # produced_mana: List[str] = Factory(list)
    # keywords: list = Factory(list)


@define
class CardFace:
    name: str
    type_line: str
    mana_cost: str
    