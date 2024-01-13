import logging
import chrmndr.engine.mechanics.actions as action 
from typing import List
from chrmndr.models.card import Card

logger = logging.getLogger("game")


def craft(c_card: Card, materials: List[Card], t_card: Card):
    logger.info(f"Crafting: {c_card}")
    action.exile(c_card)
    action.exile(materials)

    logger.info(f"Crafting: Pay mana cost")
    action.pay_mana_cost()    
    
    logger.info(f"Crafting: Transform")
    action.transform(t_card)