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
            },
            confirmed:{
                type: Sequelize.BOOLEAN,
                allowNull: false,
                defaultValue: true,
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
        db.University.hasMany(db.User,{foreignKey:'universityId',sourceKey:'id'})
    }
};
module.exports = University;