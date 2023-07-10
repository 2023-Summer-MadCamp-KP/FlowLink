const Sequelize = require('sequelize');

class User extends Sequelize.Model {
    static initiate(sequelize) {
        User.init({
            name: {
                type: Sequelize.STRING(100),
                allowNull: true,
            },
            token: {
                type: Sequelize.STRING(100),
                allowNull: true,
            },
            gradOf:{
                type : Sequelize.INTEGER,
                allowNull: true,

            }, 
            uid:{
                type : Sequelize.STRING(100),
                allowNull: true,
            },
            password:{
                type : Sequelize.STRING(100),
                allowNull: true,
            
            },
            platform:{
                type : Sequelize.STRING(100),
                allowNull: true,
            },
            prtcpntYear:{
                type : Sequelize.INTEGER,
                allowNull: true,
            }
        }
            , {
                sequelize,
                timestamps: false,
                modelName: 'User',
                tableName: 'user',
                paranoid: false,
                charset: 'utf8mb4',
                collate: 'utf8mb4_general_ci',

            });
    }
    static associate(db) {
        
        db.User.belongsToMany(db.Interest,{through:'UserInterest'});
    }
};
module.exports = User;