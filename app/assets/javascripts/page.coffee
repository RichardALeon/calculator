# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $(document).ready ->
    $.get('page/memory').done (result) ->
      $("#mem_" + (i + 1)).text(result.memory[i].substring(0, 20)) for i in [0..9]

    $(".number").click (event) ->
      appendCharacter(event.target.innerText)

    $(".operationButton").click (event) ->
      setOperation(event.target.innerText)

    $(".pastResult").click (event) ->
      if ($("#operation").text() == "=")
        $("#display").text(event.target.innerText)
        $("#operation").empty()
        $("#heldValue").empty()
      else
        $("#display").text(event.target.innerText)

    $("#equalsButton").click ->
      execute($("#operation").text())

    $("#backspaceButton").click ->
      text = $("#display").text();
      text = text.slice(0, text.length - 1)
      $("#display").text(text)

    timeoutId = 0
    $("#backspaceButton").on "mousedown", ->
      timeoutId = setTimeout(clearDisplay, 250)

    $("#backspaceButton").on "mouseup mouseleave", ->
      clearTimeout(timeoutId)

    $("#clearButton").click ->
      $("#display").empty()
      $("#heldValue").empty()
      $("#operation").empty()

    $("#negate").click ->
      text = $("#display").text()
      if(text == "")
        return

      if (text.indexOf("-") == -1)
        $("#display").text("-".concat(text))
      else
        $("#display").text(text.slice(1, text.length))

  clearDisplay = () ->
    $("#display").empty()
    if ($("#operation").text() == "=")
      $("#operation").empty()
      $("#heldValue").empty()

  appendCharacter = (character) ->
    if (character == ".")
      if ($("#display").text().indexOf(".") != -1)
        return

    if (character == "0")
      if ($("#display").text() == "0")
        return

    if ($("#operation").text() == "=")
      $("#display").text(character)
      $("#operation").empty()
      $("#heldValue").empty()
    else if  ($("#display").text() == "0" || $("#display").text() == "NaN" || $("#display").text() == "Infinity")
      $("#display").text(character)
    else
      $("#display").text($("#display").text() + character)

    if ($("#display").text() == ".")
      $("#display").text("0.")

  execute = (operation) ->
    if ($("#display").text() == "" || (operation != "sqrt" && $("#heldValue").text() == "") || $("#operation").text() == "=" && operation != "sqrt")
      return

    displayValue = $("#display").text()
    heldValue = $("#heldValue").text()
    #submit display, heldValue, operation for evaluation
    #set result in displayValue
    $.get('page/execute', {"left":heldValue, operation, "right":displayValue}).done (result) ->
          $("#operation").text("=")
          $("#display").text(result.result) #result
          $("#heldValue").text(heldValue + " " + operation + " " + displayValue)

          $("#mem_" + (i + 1)).text(result.memory[i].substring(0, 20)) for i in [0..9]


  setOperation = (operation) ->
    if ($("#display").text() == "" || $("#display").text() == "NaN" || $("#display").text() == "Infinity")
      return

    if (operation == "sqrt")
      $("#heldValue").empty()
      execute(operation)
    else if ($("#operation").text() != "" && $("#operation").text() != "=")
      $("#operation").text(operation)
    else
      $("#heldValue").text($("#display").text())
      $("#display").empty()
      $("#operation").text(operation)
