using { AdminService.Authors,
        AdminService.Books
 } from './admin-service';

 annotate Books with @(restrict:[
    {
        grand:['DELETE'],
        to: 'admin',
        where: 'stock = 0',
    },
    {
        grand:[
            'READ',
            'CREATE',
            'UPDATE'
            ],
        to: 'admin',
    }
 ]);

 annotate Authors with @(requires: 'admin'); 

 
 
