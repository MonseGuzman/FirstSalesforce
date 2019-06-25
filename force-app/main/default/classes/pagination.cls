public class pagination {
    ApexPages.StandardSetController controller;
    
    public pagination(ApexPages.StandardSetController controller) {
        this.controller = controller;
        controller.setPageSize(5);
    }
    public pageReference ShowAll() {
        controller.setPageSize(controller.getResultSize());
        return null;
    }
}