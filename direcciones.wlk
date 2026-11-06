import game.*
import personajes.*
import estados.*
import cosasEntorno.*


object arriba {

    method nombre() {
        return "arriba"
    }

    method siguiente(position) {
        return position.up(1)
    }
    
    method validarNuevaPosicion(personaje, nuevaPosicion, objetos) {
        if(self.sonAtravesables(objetos)) {
            personaje.position(nuevaPosicion)
        }
    }
    method sonAtravesables(objetos){
        return objetos.all({ objeto => objeto.esAtravesable() })
  }
}


object abajo {

    method nombre() {
        return "abajo"
    }

    method siguiente(position) {
        return position.down(1)
    }

    method validarNuevaPosicion(personaje, nuevaPosicion, objetos) {
        if(self.sonAtravesables(objetos)) {
            personaje.position(nuevaPosicion)
        }
    }
    method sonAtravesables(objetos){
        return objetos.all({ objeto => objeto.esAtravesable() })
  }
}


object derecha {

    method nombre() {
        return "derecha"
    }

    method siguiente(position) {
        return position.right(1)
    }

    method validarNuevaPosicion(personaje, nuevaPosicion, objetos) {
        if(self.sonAtravesables(objetos)) {
            personaje.position(nuevaPosicion)
        }
    }

    method sonAtravesables(objetos){
        return objetos.all({ objeto => objeto.esAtravesable() })
    
    }
}


object izquierda {

    method nombre() {
        return "izquierda"
    }

    method siguiente(position) {
        return position.left(1)
    }

    method validarNuevaPosicion(personaje, nuevaPosicion, objetos) {
        if(self.sonAtravesables(objetos)) {
            personaje.position(nuevaPosicion)
        }
    }
    method sonAtravesables(objetos){
        return objetos.all({ objeto => objeto.esAtravesable() })
  }
}