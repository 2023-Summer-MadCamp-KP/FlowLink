const Sequelize = require('sequelize');

class User extends Sequelize.Model {
    static initiate(sequelize) {
        User.init({
            name: {
                type: Sequelize.STRING(100),
                allowNull: true,
            },
            token: {
                type: Sequelize.STRING(500),
                allowNull: true,
                unique: true,
            },
            gradOf:{
                type : Sequelize.INTEGER,
                allowNull: true,

            }, 
            uid:{
                type : Sequelize.STRING(100),
                allowNull: false,
            },
            password:{
                type : Sequelize.STRING(100),
                allowNull: false,
            
            },
            platform:{
              //  'normal','kakao'
                type : Sequelize.STRING(100),
                allowNull: true,
            },
            prtcpntYear:{
             //  2023 여름 1분반
            // 202321
                type : Sequelize.INTEGER,
                allowNull: true,
            },
            emailConfirmed:{
                type:Sequelize.BOOLEAN,
                allowNull:false,
                defaultValue:true,
            },
            infoConfirmed:{
                type:Sequelize.BOOLEAN,
                allowNull:false,
                defaultValue:false,
            },
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

        db.User.hasMany(db.Like,{foreignKey:'likeFrom',sourceKey:'id'});
        db.User.hasMany(db.Like,{foreignKey:'likeTo',sourceKey:'id'});
        
    }
};
module.exports = User;