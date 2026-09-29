

object guerrero {
  var energy = 100
  var position = game.origin()
  var posicionDeMira = miraAbajo

  method energy(){
    return energy
  }

  method position(){
    return position
  }

  method image() {
    return posicionDeMira.image()
  }
}

object miraAbajo {

    var estadoActual = 1

    method image() {
        return "abajo_" + estadoActual  + ".png"
    }

    method siguienteFrame() {
        if (estadoActual < 12) {
            estadoActual = estadoActual + 1
        }
        else {
          estadoActual = 1
        }
    }
}