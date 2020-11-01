module.exports = function(app) {
 
    const customers = require('../controller/customer.controller.js');
    const validator = require('express-joi-validation').createValidator({})
    const Joi = require('joi')
    const updateSchema = Joi.object({
    firstname: Joi.string().required(),
    lastname: Joi.string(),
    age: Joi.number().required()
    })

    const querySchema = Joi.object({
      customerId: Joi.number().integer().required()
    });
    

    // Create a new Customer
    app.post('/api/customers', validator.body(updateSchema), customers.create);
 
    // Retrieve all Customer
    app.get('/api/customers', customers.findAll);
 
    // Retrieve a single Customer by Id
    app.get('/api/customers/:customerId', validator.params(querySchema), customers.findById);
 
    // Update a Customer with Id
    app.put('/api/customers/:customerId', validator.params(querySchema) , validator.body(updateSchema), customers.update);
 
    // Delete a Customer with Id
    app.delete('/api/customers/:customerId', validator.params(querySchema), customers.delete);

    // Get health
    app.get('/api/health',  (req, res) => { res.send("API is up")});
   
}