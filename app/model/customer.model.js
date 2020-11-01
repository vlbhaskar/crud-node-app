module.exports = (sequelize, Sequelize) => {
	const Customer = sequelize.define('customer', {
		id: {
			type: Sequelize.INTEGER,
			autoIncrement: true,
			primaryKey: true
		},
		firstname: {
		type: Sequelize.STRING
		},
		lastname: {
		type: Sequelize.STRING
		},
		age: {
			type: Sequelize.INTEGER
		},
		createdAt: {
			type: Sequelize.DATE,
			allowNull: false,
			defaultValue: Sequelize.NOW
		},
		updatedAt: {
		type: Sequelize.DATE,
		allowNull: false,
		defaultValue: Sequelize.NOW
		}
	});
	
	return Customer;
}