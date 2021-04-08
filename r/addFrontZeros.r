addFrontZeros = function(number) {

  if ((number >= 1) && (number <= 9)) {
    string_with_zeros = paste0("00", number)
  } else if ((number >= 10) && (number <= 99)) {
    string_with_zeros = paste0("0", number)
  } else {
    string_with_zeros = toString(number)
  }

  return(string_with_zeros)
}
