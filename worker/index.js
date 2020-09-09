import { create, all } from 'mathjs';
const config = { };
const math = create(all, config);
const keys = require('./keys');
const redis = require('redis');


const redisClient = redis.createClient({
  host: keys.redisHost,
  port: keys.redisPort,
  retry_strategy: () => 1000
});
const sub = redisClient.duplicate();

//function fib(index) {
//  if (index < 2) return 1;
//  return fib(index - 1) + fib(index - 2);
//}

function fib(index) {
    var neo = math.matrix([[1, 1], [1, 0]]);
    // raise to power of index
    var morpheus = math.power(neo, index); 
    // return subset ( top right)
    return math.subset(morpheus, math.index(0, 1));
}

sub.on('message', (channel, message) => {
  redisClient.hset('values', message, fib(parseInt(message)));
});
sub.subscribe('insert');
