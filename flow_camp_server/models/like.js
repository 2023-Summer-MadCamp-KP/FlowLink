const Sequelize = require('sequelize');

class Like extends Sequelize.Model {
    static initiate(sequelize) {
        Like.init({
        }
            , {
                sequelize,
                timestamps: false,
                modelName: 'Like',
                tableName: 'like',
                paranoid: false,
                charset: 'utf8mb4',
                collate: 'utf8mb4_general_ci',

            });
    }
    static associate(db) {
        db.Like.belongsTo(db.User, {as:'likeFromUser', foreignKey: 'likeFrom', targetKey: 'id' });
        db.Like.belongsTo(db.User, {as:'likeToUser', foreignKey: 'likeTo', targetKey: 'id' });
    }
    
};
module.exports = Like;