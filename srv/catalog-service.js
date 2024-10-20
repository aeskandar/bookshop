const cds = require('@sap/cds')

module.exports = async function() {
    //look for other examples, on samples or actual project code, question was
    // if not the in-memory db , would this change to a link for the persistence db instead of 'db' ?
    const db = await cds.connect.to('db');

    // destructuring, db.entities is built in gives all entity names, Authors, Books, Genres ...
    const { Books } = db.entities;

    // this is defined in the service cds file as an action and at the same time registers a path
    this.on ('sendOrder', async req => {

        // these are defined in the service cds file, because I wondered why book and Quantity, what if Anzahl instead
        const {book,quantity} = req.data


        const n = await UPDATE (Books, book)
            .with ({ stock: {'-=': quantity }})
            .where ({ stock: {'>=': quantity }})
        n > 0 || req.error (409,`${quantity} exceeds stock for book #${book}`)
    })

    // Add some discount for overstocked books
    this.after ('each','Books', book => {
        if (book.stock > 111) book.title += ` -- 11% discount!`
    })
}