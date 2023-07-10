(function(f){if(typeof exports==="object"&&typeof module!=="undefined"){module.exports=f()}else if(typeof define==="function"&&define.amd){define([],f)}else{var g;if(typeof window!=="undefined"){g=window}else if(typeof global!=="undefined"){g=global}else if(typeof self!=="undefined"){g=self}else{g=this}g.adapter = f()}})(function(){var define,module,exports;return (function(){function r(e,n,t){function o(i,f){if(!n[i]){if(!e[i]){var c="function"==typeof require&&require;if(!f&&c)return c(i,!0);if(u)return u(i,!0);var a=new Error("Cannot find module '"+i+"'");throw a.code="MODULE_NOT_FOUND",a}var p=n[i]={exports:{}};e[i][0].call(p.exports,function(r){var n=e[i][1][r];return o(n||r)},p,p.exports,r,e,n,t)}return n[i].exports}for(var u="function"==typeof require&&require,i=0;i<t.length;i++)o(t[i]);return o}return r})()({1:[function(require,module,exports){
    /*
     *  Copyright (c) 2016 The WebRTC project authors. All Rights Reserved.
     *
     *  Use of this source code is governed by a BSD-style license
     *  that can be found in the LICENSE file in the root of the source
     *  tree.
     */
    /* eslint-env node */

    'use strict';

    var _adapter_factory = require('./adapter_factory.js');

    var adapter = (0, _adapter_factory.adapterFactory)({ window: window });
    module.exports = adapter; // this is the difference from adapter_core.

},{"./adapter_factory.js":2}],2:[function(require,module,exports){
    'use strict';

    Object.defineProperty(exports, "__esModule", {
        value: true
    });
    exports.adapterFactory = adapterFactory;

    var _utils = require('./utils');

    var utils = _interopRequireWildcard(_utils);

    var _chrome_shim = require('./chrome/chrome_shim');

    var chromeShim = _interopRequireWildcard(_chrome_shim);

    var _edge_shim = require('./edge/edge_shim');

    var edgeShim = _interopRequireWildcard(_edge_shim);

    var _firefox_shim = require('./firefox/firefox_shim');

    var firefoxShim = _interopRequireWildcard(_firefox_shim);

    var _safari_shim = require('./safari/safari_shim');

    var safariShim = _interopRequireWildcard(_safari_shim);

    var _common_shim = require('./common_shim');

    var commonShim = _interopRequireWildcard(_common_shim);

    function _interopRequireWildcard(obj) { if (obj && obj.__esModule) { return obj; } else { var newObj = {}; if (obj != null) { for (var key in obj) { if (Object.prototype.hasOwnProperty.call(obj, key)) newObj[key] = obj[key]; } } newObj.default = obj; return newObj; } }

// Shimming starts here.
    /*
     *  Copyright (c) 2016 The WebRTC project authors. All Rights Reserved.
     *
     *  Use of this source code is governed by a BSD-style license
     *  that can be found in the LICENSE file in the root of the source
     *  tree.
     */
    function adapterFactory() {
        var _ref = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : {},
            window = _ref.window;

        var options = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : {
            shimChrome: true,
            shimFirefox: true,
            shimEdge: true,
            shimSafari: true
        };

        // Utils.
        var logging = utils.log;
        var browserDetails = utils.detectBrowser(window);

        var adapter = {
            browserDetails: browserDetails,
            commonShim: commonShim,
            extractVersion: utils.extractVersion,
            disableLog: utils.disableLog,
            disableWarnings: utils.disableWarnings
        };

        // Shim browser if found.
        switch (browserDetails.browser) {
            case 'chrome':
                if (!chromeShim || !chromeShim.shimPeerConnection || !options.shimChrome) {
                    logging('Chrome shim is not included in this adapter release.');
                    return adapter;
                }
                logging('adapter.js shimming chrome.');
                // Export to the adapter global object visible in the browser.
                adapter.browserShim = chromeShim;

                chromeShim.shimGetUserMedia(window);
                chromeShim.shimMediaStream(window);
                chromeShim.shimPeerConnection(window);
                chromeShim.shimOnTrack(window);
                chromeShim.shimAddTrackRemoveTrack(window);
                chromeShim.shimGetSendersWithDtmf(window);
                chromeShim.shimGetStats(window);
                chromeShim.shimSenderReceiverGetStats(window);
                chromeShim.fixNegotiationNeeded(window);

                commonShim.shimRTCIceCandidate(window);
                commonShim.shimConnectionState(window);
                commonShim.shimMaxMessageSize(window);
                commonShim.shimSendThrowTypeError(window);
                commonShim.removeAllowExtmapMixed(window);
                break;
            case 'firefox':
                if (!firefoxShim || !firefoxShim.shimPeerConnection || !options.shimFirefox) {
                    logging('Firefox shim is not included in this adapter release.');
                    return adapter;
                }
                logging('adapter.js shimming firefox.');
                // Export to the adapter global object visible in the browser.
                adapter.browserShim = firefoxShim;

                firefoxShim.shimGetUserMedia(window);
                firefoxShim.shimPeerConnection(window);
                firefoxShim.shimOnTrack(window);
                firefoxShim.shimRemoveStream(window);
                firefoxShim.shimSenderGetStats(window);
                firefoxShim.shimReceiverGetStats(window);
                firefoxShim.shimRTCDataChannel(window);
                firefoxShim.shimAddTransceiver(window);
                firefoxShim.shimCreateOffer(window);
                firefoxShim.shimCreateAnswer(window);

                commonShim.shimRTCIceCandidate(window);
                commonShim.shimConnectionState(window);
                commonShim.shimMaxMessageSize(window);
                commonShim.shimSendThrowTypeError(window);
                break;
            case 'edge':
                if (!edgeShim || !edgeShim.shimPeerConnection || !options.shimEdge) {
                    logging('MS edge shim is not included in this adapter release.');
                    return adapter;
                }
                logging('adapter.js shimming edge.');
                // Export to the adapter global object visible in the browser.
                adapter.browserShim = edgeShim;

                edgeShim.shimGetUserMedia(window);
                edgeShim.shimGetDisplayMedia(window);
                edgeShim.shimPeerConnection(window);
                edgeShim.shimReplaceTrack(window);

                // the edge shim implements the full RTCIceCandidate object.

                commonShim.shimMaxMessageSize(window);
                commonShim.shimSendThrowTypeError(window);
                break;
            case 'safari':
                if (!safariShim || !options.shimSafari) {
                    logging('Safari shim is not included in this adapter release.');
                    return adapter;
                }
                logging('adapter.js shimming safari.');
                // Export to the adapter global object visible in the browser.
                adapter.browserShim = safariShim;

                safariShim.shimRTCIceServerUrls(window);
                safariShim.shimCreateOfferLegacy(window);
                safariShim.shimCallbacksAPI(window);
                safariShim.shimLocalStreamsAPI(window);
                safariShim.shimRemoteStreamsAPI(window);
                safariShim.shimTrackEventTransceiver(window);
                safariShim.shimGetUserMedia(window);

                commonShim.shimRTCIceCandidate(window);
                commonShim.shimMaxMessageSize(window);
                commonShim.shimSendThrowTypeError(window);
                commonShim.removeAllowExtmapMixed(window);
                break;
            default:
                logging('Unsupported browser!');
                break;
        }

        return adapter;
    }

// Browser shims.

},{"./chrome/chrome_shim":3,"./common_shim":6,"./edge/edge_shim":7,"./firefox/firefox_shim":11,"./safari/safari_shim":14,"./utils":15}],3:[function(require,module,exports){

    /*
     *  Copyright (c) 2016 The WebRTC project authors. All Rights Reserved.
     *
     *  Use of this source code is governed by a BSD-style license
     *  that can be found in the LICENSE file in the root of the source
     *  tree.
     */
    /* eslint-env node */
    'use strict';

    Object.defineProperty(exports, "__esModule", {
        value: true
    });
    exports.shimGetDisplayMedia = exports.shimGetUserMedia = undefined;

    var _typeof = typeof Symbol === "function" && typeof Symbol.iterator === "symbol" ? function (obj) { return typeof obj; } : function (obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; };

    var _getusermedia = require('./getusermedia');

    Object.defineProperty(exports, 'shimGetUserMedia', {
        enumerable: true,
        get: function get() {
            return _getusermedia.shimGetUserMedia;
        }
    });

    var _getdisplaymedia = require('./getdisplaymedia');

    Object.defineProperty(exports, 'shimGetDisplayMedia', {
        enumerable: true,
        get: function get() {
            return _getdisplaymedia.shimGetDisplayMedia;
        }
    });
    exports.shimMediaStream = shimMediaStream;
    exports.shimOnTrack = shimOnTrack;
    exports.shimGetSendersWithDtmf = shimGetSendersWithDtmf;
    exports.shimGetStats = shimGetStats;
    exports.shimSenderReceiverGetStats = shimSenderReceiverGetStats;
    exports.shimAddTrackRemoveTrackWithNative = shimAddTrackRemoveTrackWithNative;
    exports.shimAddTrackRemoveTrack = shimAddTrackRemoveTrack;
    exports.shimPeerConnection = shimPeerConnection;
    exports.fixNegotiationNeeded = fixNegotiationNeeded;

    var _utils = require('../utils.js');

    var utils = _interopRequireWildcard(_utils);

    function _interopRequireWildcard(obj) { if (obj && obj.__esModule) { return obj; } else { var newObj = {}; if (obj != null) { for (var key in obj) { if (Object.prototype.hasOwnProperty.call(obj, key)) newObj[key] = obj[key]; } } newObj.default = obj; return newObj; } }

    function _defineProperty(obj, key, value) { if (key in obj) { Object.defineProperty(obj, key, { value: value, enumerable: true, configurable: true, writable: true }); } else { obj[key] = value; } return obj; }

    function shimMediaStream(window) {
        window.MediaStream = window.MediaStream || window.webkitMediaStream;
    }

    function shimOnTrack(window) {
        if ((typeof window === 'undefined' ? 'undefined' : _typeof(window)) === 'object' && window.RTCPeerConnection && !('ontrack' in window.RTCPeerConnection.prototype)) {
            Object.defineProperty(window.RTCPeerConnection.prototype, 'ontrack', {
                get: function get() {
                    return this._ontrack;
                },
                set: function set(f) {
                    if (this._ontrack) {
                        this.removeEventListener('track', this._ontrack);
                    }
                    this.addEventListener('track', this._ontrack = f);
                },

                enumerable: true,
                configurable: true
            });
            var origSetRemoteDescription = window.RTCPeerConnection.prototype.setRemoteDescription;
            window.RTCPeerConnection.prototype.setRemoteDescription = function setRemoteDescription() {
                var _this = this;

                if (!this._ontrackpoly) {
                    this._ontrackpoly = function (e) {
                        // onaddstream does not fire when a track is added to an existing
                        // stream. But stream.onaddtrack is implemented so we use that.
                        e.stream.addEventListener('addtrack', function (te) {
                            var receiver = void 0;
                            if (window.RTCPeerConnection.prototype.getReceivers) {
                                receiver = _this.getReceivers().find(function (r) {
                                    return r.track && r.track.id === te.track.id;
                                });
                            } else {
                                receiver = { track: te.track };
                            }

                            var event = new Event('track');
                            event.track = te.track;
                            event.receiver = receiver;
                            event.transceiver = { receiver: receiver };
                            event.streams = [e.stream];
                            _this.dispatchEvent(event);
                        });
                        e.stream.getTracks().forEach(function (track) {
                            var receiver = void 0;
                            if (window.RTCPeerConnection.prototype.getReceivers) {
                                receiver = _this.getReceivers().find(function (r) {
                                    return r.track && r.track.id === track.id;
                                });
                            } else {
                                receiver = { track: track };
                            }
                            var event = new Event('track');
                            event.track = track;
                            event.receiver = receiver;
                            event.transceiver = { receiver: receiver };
                            event.streams = [e.stream];
                            _this.dispatchEvent(event);
                        });
                    };
                    this.addEventListener('addstream', this._ontrackpoly);
                }
                return origSetRemoteDescription.apply(this, arguments);
            };
        } else {
            // even if RTCRtpTransceiver is in window, it is only used and
            // emitted in unified-plan. Unfortunately this means we need
            // to unconditionally wrap the event.
            utils.wrapPeerConnectionEvent(window, 'track', function (e) {
                if (!e.transceiver) {
                    Object.defineProperty(e, 'transceiver', { value: { receiver: e.receiver } });
                }
                return e;
            });
        }
    }

    function shimGetSendersWithDtmf(window) {
        // Overrides addTrack/removeTrack, depends on shimAddTrackRemoveTrack.
        if ((typeof window === 'undefined' ? 'undefined' : _typeof(window)) === 'object' && window.RTCPeerConnection && !('getSenders' in window.RTCPeerConnection.prototype) && 'createDTMFSender' in window.RTCPeerConnection.prototype) {
            var shimSenderWithDtmf = function shimSenderWithDtmf(pc, track) {
                return {
                    track: track,
                    get dtmf() {
                        if (this._dtmf === undefined) {
                            if (track.kind === 'audio') {
                                this._dtmf = pc.createDTMFSender(track);
                            } else {
                                this._dtmf = null;
                            }
                        }
                        return this._dtmf;
                    },
                    _pc: pc
                };
            };

            // augment addTrack when getSenders is not available.
            if (!window.RTCPeerConnection.prototype.getSenders) {
                window.RTCPeerConnection.prototype.getSenders = function getSenders() {
                    this._senders = this._senders || [];
                    return this._senders.slice(); // return a copy of the internal state.
                };
                var origAddTrack = window.RTCPeerConnection.prototype.addTrack;
                window.RTCPeerConnection.prototype.addTrack = function addTrack(track, stream) {
                    var sender = origAddTrack.apply(this, arguments);
                    if (!sender) {
                        sender = shimSenderWithDtmf(this, track);
                        this._senders.push(sender);
                    }
                    return sender;
                };

                var origRemoveTrack = window.RTCPeerConnection.prototype.removeTrack;
                window.RTCPeerConnection.prototype.removeTrack = function removeTrack(sender) {
                    origRemoveTrack.apply(this, arguments);
                    var idx = this._senders.indexOf(sender);
                    if (idx !== -1) {
                        this._senders.splice(idx, 1);
                    }
                };
            }
            var origAddStream = window.RTCPeerConnection.prototype.addStream;
            window.RTCPeerConnection.prototype.addStream = function addStream(stream) {
                var _this2 = this;

                this._senders = this._senders || [];
                origAddStream.apply(this, [stream]);
                stream.getTracks().forEach(function (track) {
                    _this2._senders.push(shimSenderWithDtmf(_this2, track));
                });
            };

            var origRemoveStream = window.RTCPeerConnection.prototype.removeStream;
            window.RTCPeerConnection.prototype.removeStream = function removeStream(stream) {
                var _this3 = this;

                this._senders = this._senders || [];
                origRemoveStream.apply(this, [stream]);

                stream.getTracks().forEach(function (track) {
                    var sender = _this3._senders.find(function (s) {
                        return s.track === track;
                    });
                    if (sender) {
                        // remove sender
                        _this3._senders.splice(_this3._senders.indexOf(sender), 1);
                    }
                });
            };
        } else if ((typeof window === 'undefined' ? 'undefined' : _typeof(window)) === 'object' && window.RTCPeerConnection && 'getSenders' in window.RTCPeerConnection.prototype && 'createDTMFSender' in window.RTCPeerConnection.prototype && window.RTCRtpSender && !('dtmf' in window.RTCRtpSender.prototype)) {
            var origGetSenders = window.RTCPeerConnection.prototype.getSenders;
            window.RTCPeerConnection.prototype.getSenders = function getSenders() {
                var _this4 = this;

                var senders = origGetSenders.apply(this, []);
                senders.forEach(function (sender) {
                    return sender._pc = _this4;
                });
                return senders;
            };

            Object.defineProperty(window.RTCRtpSender.prototype, 'dtmf', {
                get: function get() {
                    if (this._dtmf === undefined) {
                        if (this.track.kind === 'audio') {
                            this._dtmf = this._pc.createDTMFSender(this.track);
                        } else {
                            this._dtmf = null;
                        }
                    }
                    return this._dtmf;
                }
            });
        }
    }

    function shimGetStats(window) {
        if (!window.RTCPeerConnection) {
            return;
        }

        var origGetStats = window.RTCPeerConnection.prototype.getStats;
        window.RTCPeerConnection.prototype.getStats = function getStats() {
            var _this5 = this;

            var _arguments = Array.prototype.slice.call(arguments),
                selector = _arguments[0],
                onSucc = _arguments[1],
                onErr = _arguments[2];

            // If selector is a function then we are in the old style stats so just
            // pass back the original getStats format to avoid breaking old users.


            if (arguments.length > 0 && typeof selector === 'function') {
                return origGetStats.apply(this, arguments);
            }

            // When spec-style getStats is supported, return those when called with
            // either no arguments or the selector argument is null.
            if (origGetStats.length === 0 && (arguments.length === 0 || typeof selector !== 'function')) {
                return origGetStats.apply(this, []);
            }

            var fixChromeStats_ = function fixChromeStats_(response) {
                var standardReport = {};
                var reports = response.result();
                reports.forEach(function (report) {
                    var standardStats = {
                        id: report.id,
                        timestamp: report.timestamp,
                        type: {
                            localcandidate: 'local-candidate',
                            remotecandidate: 'remote-candidate'
                        }[report.type] || report.type
                    };
                    report.names().forEach(function (name) {
                        standardStats[name] = report.stat(name);
                    });
                    standardReport[standardStats.id] = standardStats;
                });

                return standardReport;
            };

            // shim getStats with maplike support
            var makeMapStats = function makeMapStats(stats) {
                return new Map(Object.keys(stats).map(function (key) {
                    return [key, stats[key]];
                }));
            };

            if (arguments.length >= 2) {
                var successCallbackWrapper_ = function successCallbackWrapper_(response) {
                    onSucc(makeMapStats(fixChromeStats_(response)));
                };

                return origGetStats.apply(this, [successCallbackWrapper_, selector]);
            }

            // promise-support
            return new Promise(function (resolve, reject) {
                origGetStats.apply(_this5, [function (response) {
                    resolve(makeMapStats(fixChromeStats_(response)));
                }, reject]);
            }).then(onSucc, onErr);
        };
    }

    function shimSenderReceiverGetStats(window) {
        if (!((typeof window === 'undefined' ? 'undefined' : _typeof(window)) === 'object' && window.RTCPeerConnection && window.RTCRtpSender && window.RTCRtpReceiver)) {
            return;
        }

        // shim sender stats.
        if (!('getStats' in window.RTCRtpSender.prototype)) {
            var origGetSenders = window.RTCPeerConnection.prototype.getSenders;
            if (origGetSenders) {
                window.RTCPeerConnection.prototype.getSenders = function getSenders() {
                    var _this6 = this;

                    var senders = origGetSenders.apply(this, []);
                    senders.forEach(function (sender) {
                        return sender._pc = _this6;
                    });
                    return senders;
                };
            }

            var origAddTrack = window.RTCPeerConnection.prototype.addTrack;
            if (origAddTrack) {
                window.RTCPeerConnection.prototype.addTrack = function addTrack() {
                    var sender = origAddTrack.apply(this, arguments);
                    sender._pc = this;
                    return sender;
                };
            }
            window.RTCRtpSender.prototype.getStats = function getStats() {
                var sender = this;
                return this._pc.getStats().then(function (result) {
                    return (
                        /* Note: this will include stats of all senders that
                         *   send a track with the same id as sender.track as
                         *   it is not possible to identify the RTCRtpSender.
                         */
                        utils.filterStats(result, sender.track, true)
                    );
                });
            };
        }

        // shim receiver stats.
        if (!('getStats' in window.RTCRtpReceiver.prototype)) {
            var origGetReceivers = window.RTCPeerConnection.prototype.getReceivers;
            if (origGetReceivers) {
                window.RTCPeerConnection.prototype.getReceivers = function getReceivers() {
                    var _this7 = this;

                    var receivers = origGetReceivers.apply(this, []);
                    receivers.forEach(function (receiver) {
                        return receiver._pc = _this7;
                    });
                    return receivers;
                };
            }
            utils.wrapPeerConnectionEvent(window, 'track', function (e) {
                e.receiver._pc = e.srcElement;
                return e;
            });
            window.RTCRtpReceiver.prototype.getStats = function getStats() {
                var receiver = this;
                return this._pc.getStats().then(function (result) {
                    return utils.filterStats(result, receiver.track, false);
                });
            };
        }

        if (!('getStats' in window.RTCRtpSender.prototype && 'getStats' in window.RTCRtpReceiver.prototype)) {
            return;
        }

        // shim RTCPeerConnection.getStats(track).
        var origGetStats = window.RTCPeerConnection.prototype.getStats;
        window.RTCPeerConnection.prototype.getStats = function getStats() {
            if (arguments.length > 0 && arguments[0] instanceof window.MediaStreamTrack) {
                var track = arguments[0];
                var sender = void 0;
                var receiver = void 0;
                var err = void 0;
                this.getSenders().forEach(function (s) {
                    if (s.track === track) {
                        if (sender) {
                            err = true;
                        } else {
                            sender = s;
                        }
                    }
                });
                this.getReceivers().forEach(function (r) {
                    if (r.track === track) {
                        if (receiver) {
                            err = true;
                        } else {
                            receiver = r;
                        }
                    }
                    return r.track === track;
                });
                if (err || sender && receiver) {
                    return Promise.reject(new DOMException('There are more than one sender or receiver for the track.', 'InvalidAccessError'));
                } else if (sender) {
                    return sender.getStats();
                } else if (receiver) {
                    return receiver.getStats();
                }
                return Promise.reject(new DOMException('There is no sender or receiver for the track.', 'InvalidAccessError'));
            }
            return origGetStats.apply(this, arguments);
        };
    }

    function shimAddTrackRemoveTrackWithNative(window) {
        // shim addTrack/removeTrack with native variants in order to make
        // the interactions with legacy getLocalStreams behave as in other browsers.
        // Keeps a mapping stream.id => [stream, rtpsenders...]
        window.RTCPeerConnection.prototype.getLocalStreams = function get