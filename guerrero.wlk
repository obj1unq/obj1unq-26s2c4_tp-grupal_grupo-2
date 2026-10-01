import direcciones.*

object guerrero {
  var property energy = 100
  var property position = game.origin()
  var property posicionDeMira = abajo1

  method energy(){
    return energy
  }

  method position(){
    return position
  }

  method image() {
    return posicionDeMira.image()
  }

  method mover(direccion) {
    position = direccion.siguiente(position, self)
  }

  method atacar(){
    return posicionDeMira.atacar()
  }
}


var abajo1     = new MiraADireccion(maxFramesMov = 12, direccion = "abajo_", maxFramesAtaq = 8)
var arriba1    = new MiraADireccion(maxFramesMov = 4, direccion = "arriba_", maxFramesAtaq = 8)
var derecha1   = new MiraADireccion(maxFramesMov = 12, direccion = "derecha_", maxFramesAtaq = 8)
var izquierda1 = new MiraADireccion(maxFramesMov = 12, direccion = "izquierda_", maxFramesAtaq = 8)