
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
}

class PackNacional inherits PackDeViaje {
    var provinciaDestino
    const actividades = #{}

    method agregarActividad(actividad) {
        actividades.add(actividad)
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
}



class Coordinador {
    var cantidadViajesRealizados
    var estaMotivado
    var añosExperiencia
    var rol
	const rolesValidos = [guia, asistenteLogistico, acompanante]

	method rol() {
		return rol
	} 
    method cambiarRol(nuevoRol) {
        if (rolesValidos.contains(nuevoRol)) {
            rol = nuevoRol
        }
        else { self.error("Rol invalido")}
    }
}

object guia {}
object asistenteLogistico {}
object acompanante {}

class Beneficio {
    var tipo
    var costo
    var estaVigente
}