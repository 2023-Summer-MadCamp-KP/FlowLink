const Sequelize = require('sequelize');

class Interest extends Sequelize.Model {
    static initiate(sequelize) {
        Interest.init({
            name:{
                type: Sequelize.STRING(100),
                allowNull: true,
            },
            category: {
                type: Sequelize.STRING(100),
                allowNull: true,
            },
            confirmed:{
                type: Sequelize.BOOLEAN,
                allowNull: false,
                defaultValue: false,
            }
        }
            , {
                sequelize,
                timestamps: false,
                modelName: 'Interest',
                tableName: 'interest',
                paranoid: false,
                charset: 'utf8mb4',
                collate: 'utf8mb4_general_ci',

            });
    }
    static associate(db) {
        db.Interest.belongsToMany(db.User,{through:'UserInterest'});
    }
};
module.exports = Interest;