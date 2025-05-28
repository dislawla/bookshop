const cds = require ('@sap/cds');


class CatalogService extends cds.ApplicationService{

   init(){

    const { Books } = cds.entities('CatalogService')

      // Register your event handlers in here, for example:
    this.after ('each', Books, book => { 
     if (book.stock > 111) { 
      book.title += ` -- 11% discount!`
     } 
    }) 

    this.on ('submitOrder', async req => {
        const {bookID,quantity} = req.data

        if (quantity < 1) {
          return req.error( 'INVALOD_QUANTITY' );  
        }
        const n = await UPDATE (Books, bookID)
          .with ({ stock: {'-=': quantity }})
          .where ({ stock: {'>=': quantity }})

        const book = await SELECT.one.from(Books).where({ ID: bookID });

        if (n > 0) {
          return { message: `Книга оформлена! Заказано: ${quantity} Осталось: ${book.stock}` }
        } else {
          req.error('BOOK_NOTFOUND',[bookID])
        }
      })

    return super.init(); 
   }  

    // reduceStock(req){
    //     const { book, quantity } = req.data;

    //     if (quantity < 1) {
    //         return req.error(400, 'Quantity must be at least 1');  
    //     }

    //     return 10;
    // }
}

module.exports = CatalogService;