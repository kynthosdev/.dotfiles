import logging
import chrmndr.engine.mechanics.actions as action 
from typing import List
from chrmndr.models.card import Card

logger = logging.getLogger("game")


def craft():
    logger.info(f"Crafting: Exile the permanent with craft")
    action.exile()
    logger.info(f"Crafting: Exile specified materials")
    logger.info(f"Crafting: Pay mana cost")    
    logger.info(f"Crafting: Transform")