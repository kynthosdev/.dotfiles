import { pascalCase, pathCase, snakeCase, camelCase } from 'change-case'
import { pluralize } from 'inflection'
import CONSTANTS from '../../CONSTANTS'

import moduleNamePrompt from './prompt/moduleNamePrompt'

export function prompt({ prompter, args }) {
  let prompterChain

  if (!args.name) {
    prompterChain = prompter.prompt(moduleNamePrompt)
  }

  prompterChain = prompterChain || Promise.resolve({ name: args.name })

  return prompterChain.then(answers => {
    // Here, we can expose additional data to the templates
    const modulePlural = pluralize(answers.name)
    return {
      ...answers,
      ...CONSTANTS,
      modulePascal: pascalCase(answers.name),
      moduleKebab: pathCase(answers.name),
      moduleKebabPlural: pathCase(modulePlural),
      moduleSnakePlural: snakeCase(modulePlural),
      moduleCamel: camelCase(answers.name),
      moduleCamelPlural: camelCase(modulePlural),
    }
  })
}
