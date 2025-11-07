
class PackDeViaje {
    var duracionEnDias
    var precioBase
    const beneficiosEspeciales = #{}
    var coordinadorACargo

    method agregarBeneficio(beneficio) {
        beneficiosEspeciales.add(beneficio)
    }

    method costoBeneficiosVigentes() {
        return beneficiosEspeciales.filter({b => b.estaVigente()}).sum({b => b.costo()})
    }

    method valorFinal() {
        return precioBase + self.costoBeneficiosVigentes()
    }
    method esPremium()
}

class PackNacional inherits PackDeViaje {
    var provinciaDestino
    const actividades = #{}

    method agregarActividad(actividad) {
        actividades.add(actividad)
    }
    override method esPremium(){
        return duracionEnDias > 10 && coordinadorACargo.esAltamenteCalificado()
    }
}

class PackProvincial inherits PackNacional {
  var cantCiudadesAVisitar

  override method esPremium(){
    return  self.tieneAlMenos4Actividades() &&
            self.cantCiudadesAVisitarEsMayorA5() &&
            self.tiene3BeneficiosVigentes()
  }
  method tieneAlMenos4Actividades() {
    return actividades.size() >= 4
  }
  method cantCiudadesAVisitarEsMayorA5() {
    return cantCiudadesAVisitar > 5
  }
  method tiene3BeneficiosVigentes(){
    return beneficiosEspeciales.filter({b=>b.estaVigente()}).size()>=3
  } 
  override method valorFinal() {
    return if(self.esPremium()){
        super() * 1.05
    } else{super()}
  } 
}

class PackInternacional inherits PackDeViaje {
    var paisDestino
    var cantidadEscalas
    var esLugarDeInteres

    override method valorFinal() {
        const valorConBeneficios = super()
        return valorConBeneficios * 1.2
    }
    override method esPremium(){
        return esLugarDeInteres && duracionEnDias > 20 && cantidadEscalas == 0
    }
}



class Coordinador {
    var cantidadViajesRealizados
    var estaMotivado
    var añosExperiencia
    var rol
	const rolesValidos = [guia, asistenteLogist, acompanante]

	method añosExperiencia() = añosExperiencia
    method estaMotivado() = estaMotivado
    method rol() {
		return rol
	} 
    method cambiarRol(nuevoRol) {
        if (rolesValidos.contains(nuevoRol)) {
            rol = nuevoRol
        }
        else { self.error("Rol invalido")}
    }
    method esAltamenteCalificado() {
        return cantidadViajesRealizados > 20 && rol.cumpleCondicion(self)
    }

}

object guia {
    method cumpleCondicion(unCordinador) {
        return unCordinador.estaMotivado()
    }
}
object asistenteLogist {
    method cumpleCondicion(unCordinador){
        return unCordinador.añosExperiencia() >= 3
    }
}
object acompanante {
    method cumpleCondicion(unCordinador){
        return true
    }
}

class Beneficio {
    var tipo
    var costo
    var estaVigente
    method estaVigente() = estaVigente
    method costo() = costo 
}