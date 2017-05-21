# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $(document).ready ->
    $(".number").click (event) ->
      appendCharacter(event.target.innerText)

    $(".operationButton").click (event) ->
      setOperation(event.target.innerText)

    $("#equalsButton").click ->
      execute($("#operation").text())

    $("#backspaceButton").click ->
      text = $("#display").text();
      text = text.slice(0, text.length - 1)
      $("#display").text(text)

    $("#clearButton").click ->
      $("#display").text("")
      $("#heldValue").text("")
      $("#operation").text("")

    $("#negate").click ->
      text = $("#display").text()
      if (text.indexOf("-") == -1)
        $("#display").text("-".concat(text))
      else
        $("#display").text(text.slice(1, text.length))

  appendCharacter = (character) ->
    if (character == ".")
      if ($("#display").text().indexOf(".") != -1)
        return

    if (character == "0")
      if ($("#display").text() == "0")
        return

    if ($("#operation").text() == "=")
      $("#display").text(character)
      $("#operation").text("")
      $("#heldValue").text("")
    else if  ($("#display").text() == "0")
      $("#display").text(character)
    else
      $("#display").text($("#display").text() + character)

    if ($("#display").text() == ".")
      $("#display").text("0.")

  execute = (operation) ->
    if ($("#display").text() == "" || (operation != "sqrt" && $("#heldValue").text() == ""))
      return

    displayValue = $("#display").text()
    heldValue = $("#heldValue").text()
    #submit display, heldValue, operation for evaluation
    #set result in displayValue
    $.get('page/execute', {"left":heldValue, operation, "right":displayValue}).done (result) ->
          $("#operation").text("=")
          console.log(result)
          $("#display").text(result.result) #result
          $("#heldValue").text(heldValue + " " + operation + " " + displayValue)

  setOperation = (operation) ->
    if ($("#display").text() == "" || $("#display").text() == "NaN" || $("#display").text() == "Infinity")
      return

    if (operation == "sqrt")
      $("#heldValue").text("")
      execute(operation)
    else if ($("#operation").text() != "" && $("#operation").text() != "=")
      $("#operation").text(operation)
    else
      $("#heldValue").text($("#display").text())
      $("#display").text("")
      $("#operation").text(operation)
