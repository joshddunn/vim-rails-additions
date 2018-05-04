function! s:sub(str,pat,rep)
  return substitute(a:str,'\v\C'.a:pat,a:rep,'')
endfunction

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
