public class SchedulerEmail  implements Schedulable{

   public void execute(SchedulableContext SC) {          
        BatchVerifEmailBounced email = new BatchVerifEmailBounced();
        Database.executeBatch(email,200);
   }

}