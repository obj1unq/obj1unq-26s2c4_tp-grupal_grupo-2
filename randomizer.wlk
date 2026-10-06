import wollok.game.*
import personajes.*
import direcciones.*

object movimientoAutomatico {
  const property direcciones = #{arriba, abajo, derecha, izquierda}

  method direccionRandom() {
    return direcciones.anyOne()
  }
}