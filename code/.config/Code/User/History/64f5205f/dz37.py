import logging
import chrmndr.engine.mechanics.actions as action 
from typing import List
from chrmndr.models.card import Card

logger = logging.getLogger("game")


def craft(card: Card, materials: List[Card]):
    logger.info(f"Crafting: Exile the permanent with craft")
    action.exile(card)
    
    logger.info(f"Crafting: Exile specified materials")
    action.exile(materials)

    logger.info(f"Crafting: Pay mana cost")
    action.pay_mana_cost()    
    
    logger.info(f"Crafting: Transform")