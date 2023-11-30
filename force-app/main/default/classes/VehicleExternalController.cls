public class VehicleExternalController {
    
     public static VehicleExternalModel getVehicleSIMA(String vin, String concesionario) {
        VehicleExternalModel respuesta;
		ResponseApi responseCallout;
        responseCallout = VehicleExternalCallout.getVehicleCallout(vin, concesionario);
        if (responseCallout.Status.equalsIgnoreCase('OK')) {
        	respuesta = (VehicleExternalModel) JSON.deserialize(responseCallout.Message, VehicleExternalModel.class);
            system.debug('respuesta:'+ respuesta);                 
        }
        else {
        	Exception__c exc = new Exception__c ();
         	exc.idObjetos__c = vin + '/' + concesionario;
         	exc.Exception__c = responseCallout.ErrorCode + '//'+ responseCallout.Message;
         	exc.Linea__c = 10;
         	exc.Clase_Metodo__c = 'VehicleExternalController.getVehicleSIMA';
         	insert exc;
     	}   
        return respuesta;
    }
   

}