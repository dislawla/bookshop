const cds = require ('@sap/cds');
class CatalogService extends cds.ApplicationService {
//   constructor() {
//     this.catalog = [];
//   }

//   addCatalogItem(item) {
//     this.catalog.push(item);
//   }

//   getCatalog() {
//     return this.catalog;
//   }

   init(){
    const { Books } = this.entities;

    this.after('READ',Books,this.grandDiscount);

    this.on('submitOrder',Books, this.reduceStock);

    console.log('CatalogService initialized'); // Лог при инициализации сервиса

    return super.init(); 
   }  

    grandDiscount(data){
     for (let book of data) {
          if (book.stock > 100) {
                book.title += ' -- 11% Discount';
                book.price = book.price - (book.price * 0.11);
          }
     }
     return data;
    }

    reduceStock(req){
        const { Books } = this.entities;
        const { book, quantity } = req.data;

        if (quantity < 1) {
            return req.error(400, 'Quantity must be at least 1');  
        }

        return 10;
    }
}