const Sequelize = require('sequelize');

class University extends Sequelize.Model {
    static initiate(sequelize) {
        University.init({
            name: {
                type: Sequelize.STRING(100),
                allowNull: true,
            },
            major: {
                type: Sequelize.STRING(100),
                allowNull: true,
            }
        }
            , {
                sequelize,
                timestamps: false,
                modelName: 'University',
                tableName: 'university',
                paranoid: false,
                charset: 'utf8mb4',
                collate: 'utf8mb4_general_ci',

            });
    }
    static associate(db) {
        
    }
};
module.exports = University;