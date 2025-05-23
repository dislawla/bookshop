const cds = require ('@sap/cds');


class CatalogService extends cds.ApplicationService{

   init(){
    const { Books } = this.entities;

    this.on('submitOrder', this.reduceStock);

    return super.init(); 
   }  

    reduceStock(req){
        const { book, quantity } = req.data;

        if (quantity < 1) {
            return req.error(400, 'Quantity must be at least 1');  
        }

        return 10;
    }
}

module.exports = CatalogService;