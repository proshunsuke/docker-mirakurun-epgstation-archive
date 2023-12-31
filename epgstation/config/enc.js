// ハードウェアエンコード設定
const spawn = require('child_process').spawn;
const ffmpeg = process.env.FFMPEG;

const input = process.env.INPUT;
const output = process.env.OUTPUT;
const analyzedurationSize = '10M'; // Mirakurun の設定に応じて変更すること
const probesizeSize = '32M'; // Mirakurun の設定に応じて変更すること
const dualMonoMode = 'main';
const isDualMono = parseInt(process.env.AUDIOCOMPONENTTYPE, 10) == 2;
const codec = 'h264_omx';
const videoBitrate = '10M';

const args = ['-y', '-analyzeduration', analyzedurationSize, '-probesize', probesizeSize];

// dual mono 設定
if (isDualMono) {
    Array.prototype.push.apply(args, ['-dual_mono_mode', dualMonoMode]);
}

// input 設定
Array.prototype.push.apply(args,['-i', input]);

// メタ情報を先頭に置く
Array.prototype.push.apply(args,['-movflags', 'faststart']);

// video filter 設定
let videoFilter = 'yadif';

Array.prototype.push.apply(args, ['-vf', videoFilter]);

// その他設定
Array.prototype.push.apply(args,[
    '-c:v', codec,
    '-b:v', videoBitrate,
    '-f', 'mp4',
    output
]);

let str = '';
for (let i of args) {
    str += ` ${ i }`
}
console.error(str);

const child = spawn(ffmpeg, args);

child.stderr.on('data', (data) => { console.error(String(data)); });

child.on('error', (err) => {
    console.error(err);
    throw new Error(err);
});

process.on('SIGINT', () => {
    child.kill('SIGINT');
});

