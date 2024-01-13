import logging
import chrmndr.engine.mechanics.action as action 
from typing import List
from chrmndr.models.card import Card

logger = logging.getLogger("game")


def craft(c_card: Card, materials: List[Card], t_card: Card):
    logger.info(f"Crafting: {c_card}")
    action.exile(c_card)
    action.exile(materials)
    action.pay_craft_cost()    
    action.transform(t_card)