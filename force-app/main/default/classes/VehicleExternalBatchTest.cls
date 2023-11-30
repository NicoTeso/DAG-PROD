@isTest
public class VehicleExternalBatchTest {

    @testSetup
    static void setup() {
        TriggersTest.activaTriggers();
        ApiConnect.activaApiConnect();
		CreaObjetos.creaPais();
        Concesionario__c conce = CreaObjetos.creaConcesionario('20');
        insert conce;
        Vehiculo__c veh_hyundai = new Vehiculo__c();
        veh_hyundai.VIN__c = 'VIN04';
        veh_hyundai.Concesionario__c = conce.Id;
        veh_hyundai.MarcaString__c = 'HYUNDAI';
        veh_hyundai.ModeloString__c = 'HY-01';
        veh_hyundai.kms__c = 0;
        veh_hyundai.Fecha_cumpleanos__c = Date.today().addDays(-1);
        veh_hyundai.Numero_de_cumpleanos__c = 4;
        veh_hyundai.Fecha_fin_garantia__c = Datetime.now();
        veh_hyundai.Fecha_inicio_extension_garantia__c = Datetime.now();
        veh_hyundai.Fecha_fin_extension_garantia__c = Datetime.now().addYears(2);
        veh_hyundai.Actualizar_Sima__c = true;
        veh_hyundai.Fecha_inicio_garantia__c = Datetime.now().addYears(-3);
        veh_hyundai.Fecha_primera_matriculacion__c = Datetime.now().addYears(-3);
        insert veh_hyundai;
    }
    
    @isTest
    static void batchTest() {
        Test.setMock(HttpCalloutMock.class, new ApiHttpCalloutVehicleMock());
        
        Test.startTest();
        Database.executeBatch(new VehicleExternalBatch());
        Test.stopTest();
       
        List<Vehiculo__c> vehiculos = [Select id, Actualizar_Sima__c from Vehiculo__c];
        system.assertEquals(vehiculos[0].Actualizar_Sima__c, false);
    }
    
    @isTest
    static void batchFailureTest() {
        Test.setMock(HttpCalloutMock.class, new ApiHttpCalloutMockFailure());
        
        Test.startTest();
        Database.executeBatch(new VehicleExternalBatch());
        Test.stopTest();
      
    }

}