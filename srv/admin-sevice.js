const cds = require('@sap/cds');


class AdminService extends cds.ApplicationService{

    init(){
        const { Books } = this.entities

        // this.before(['CREATE','UPDATE'], Authors, this.validateLifeData);

        this.after('READ',Books,this.grandDiscount);

        this.on('submitOrder', this.reduceStock);
    
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

    validateLifeData(req) {
        const{ dateOfBirth, dateOfDeath} = req.data;
        if (!dateOfBirth || !dateOfDeath){
            return;
        }

        const birth = new Date(dateOfBirth);
        const dead = new Date(dateOfDeath);

        if (dead < birth){
            req.error('?')
        }
    }

    reduceStock(req){
        const { bookId, quantity } = req.data;
        let books = this.entities.Books;

        if (quantity < 1) {
            return req.error(400, 'Quantity must be at least 1');  
        }

        return 10;
    }
}


module.exports = AdminService;