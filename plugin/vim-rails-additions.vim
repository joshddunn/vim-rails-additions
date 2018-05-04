function! rails#singularize(word)
  " Probably not worth it to be as comprehensive as Rails but we can
  " still hit the common cases.
  let word = a:word
  let last_word = s:sub(word, '^.+_|:', '')
  if word =~? '\.js$' || word == ''
    return word
  elseif has_key(g:rails_custom_singularize, last_word)  
    return s:sub(word, last_word . '$', g:rails_custom_singularize[last_word])
  endif
  let word = s:sub(word,'eople$','ersons')
  let word = s:sub(word,'%([Mm]ov|[aeio])@<!ies$','ys')
  let word = s:sub(word,'xe[ns]$','xs')
  let word = s:sub(word,'ves$','fs')
  let word = s:sub(word,'ss%(es)=$','sss')
  let word = s:sub(word,'s$','')
  let word = s:sub(word,'%([nrt]ch|tatus|lias)\zse$','')
  let word = s:sub(word,'%(nd|rt)\zsice$','ex')
  return word
endfunction

function! rails#pluralize(word)
  let word = a:word
  let last_word = s:sub(word, '^.+_|:', '')
  if word == ''
    return word
  elseif has_key(g:rails_custom_pluralize, last_word)  
    return s:sub(word, last_word . '$', g:rails_custom_pluralize[last_word])
  endif
  let word = s:sub(word,'[aeio]@<!y$','ie')
  let word = s:sub(word,'%(nd|rt)@<=ex$','ice')
  let word = s:sub(word,'%([sxz]|[cs]h)$','&e')
  let word = s:sub(word,'f@<!f$','ve')
  let word .= 's'
  let word = s:sub(word,'ersons$','eople')
  return word
endfunction


let s:default_projections["app/graphql/types/*_type.rb"] = {
  \    "affinity": "type",
  \    "template": ["Types::{camelcase|capitalize|colons}Type = GraphQL::ObjectType.define do", 
  \                 "  name \"{camelcase|capitalize|colons}\"",
  \                 "  description \"\"",
  \                 "end"],
  \    "type": "type"
  \ }

let s:default_projections["app/graphql/resolvers/*.rb"] = {
  \    "affinity": "resolver",
  \    "template": ["class Resolvers::{camelcase|capitalize|colons} < GraphQL::Function", 
  \                 "  type types.String",
  \                 "",
  \                 "  def call(_obj, args, ctx)",
  \                 "  end",
  \                 "end"],
  \    "type": "resolver"
  \ }

let s:default_projections["app/graphql/mutations/*_mutation.rb"] = {
  \    "affinity": "mutation",
  \    "template": ["Mutations::{camelcase|capitalize|colons}Mutation = GraphQL::Relay::Mutation.define do", 
  \                 "  name \"{camelcase|capitalize|colons}\"",
  \                 "",
  \                 "  # return_field :return_field, return_type",
  \                 "  # input_field :input_field, !input_type",
  \                 "",
  \                 "  resolve ->(obj, input, ctx) {",
  \                 "  }",
  \                 "end"],
  \    "type": "mutation"
  \ }
